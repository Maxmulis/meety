import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import { useDispatch } from 'stimulus-use'

export default class extends Controller {
  static values = {
    token: String,
    peopleMarkers: Array,
    suggestionsMarkers: Array,
    categories: Array
  }

  async connect() {
    useDispatch(this)
    mapboxgl.accessToken = this.tokenValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addPeopleMarkersToMap();
    this.#fitMapToMarkers(this.peopleMarkersValue);
    const suggestionsMarkers = await this.#fetchSuggestions()
    this.#addSuggestionsMarkersToMap(suggestionsMarkers);
    this.dispatch("hide");
    this.#fitMapToMarkers(suggestionsMarkers);

    // this.#fitMapToMarkers(suggestionsMarkers);
  }

  #addPeopleMarkersToMap() {
    this.peopleMarkersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([marker.lon, marker.lat])
        .addTo(this.map)
    });
  }

  #addSuggestionsMarkersToMap(markers) {
        markers.forEach((marker) => {
          const popup = new mapboxgl.Popup().setHTML(marker.info_window)
          new mapboxgl.Marker({ color: "#d42014" })
          .setLngLat([marker.lon, marker.lat])
          .setPopup(popup)
          .addTo(this.map);
      })
  }

  async #fetchSuggestions() {
    // fetch suggestions markers (json) from server
    // iterate over markers and add to map
    const personOne = this.peopleMarkersValue[0]
    const personTwo = this.peopleMarkersValue[1]
    const url = encodeURI(`/suggestions?person_one_lat=${personOne.lat}&person_one_lon=${personOne.lon}&person_two_lat=${personTwo.lat}&person_two_lon=${personTwo.lon}&categories=${this.categoriesValue.join(",")}`)
    const response = await fetch(url)
    const markers = await response.json();
      return markers
    };

  #fitMapToMarkers(markers) {
    const bounds = new mapboxgl.LngLatBounds()
    markers.forEach(marker => bounds.extend([marker.lon, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  };
}
