import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    token: String,
    peopleMarkers: Array,
    suggestionsMarkers: Array
  }

  connect() {
    mapboxgl.accessToken = this.tokenValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addPeopleMarkersToMap();
    this.#addSuggestionsMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addPeopleMarkersToMap() {
    this.peopleMarkersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lon, marker.lat ])
        .addTo(this.map)
    });
  }

  #addSuggestionsMarkersToMap() {
    this.suggestionsMarkersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker({color: "#d42014"})
        .setLngLat([ marker.lon, marker.lat ])
        .setPopup(popup)
        .addTo(this.map);
    }
  )};

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.peopleMarkersValue.forEach(marker => bounds.extend([ marker.lon, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  };
}
