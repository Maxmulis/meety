import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    token: String,
    peopleMarkers: Array,
    suggestionsMarkers: Array,
    categories: Array
  }

  connect() {
    mapboxgl.accessToken = this.tokenValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addPeopleMarkersToMap();
    this.#fitMapToMarkers();
    this.#fetchandaddSuggestionsMarkersToMap();
  }

  #addPeopleMarkersToMap() {
    this.peopleMarkersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([marker.lon, marker.lat])
        .addTo(this.map)
    });
  }

  #fetchandaddSuggestionsMarkersToMap() {
    // fetch suggestions markers (json) from server
    // iterate over markers and add to map
    const personOne = this.peopleMarkersValue[0]
    const personTwo = this.peopleMarkersValue[1]
    const url = encodeURI(`/suggestions?person_one_lat=${personOne.lat}&person_one_lon=${personOne.lon}&person_two_lat=${personTwo.lat}&person_two_lon=${personTwo.lon}&categories=${this.categoriesValue.join(",")}`)
    fetch(url)
      .then(response => response.json())
      .then(markers => markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window)
        new mapboxgl.Marker({ color: "#d42014" })
        .setLngLat([marker.lon, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
      })
      )};

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.peopleMarkersValue.forEach(marker => bounds.extend([marker.lon, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  };
}
