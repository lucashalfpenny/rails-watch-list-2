import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["items", "form"]
  connect() {
    console.log("Hello from insert in list controller")
    console.log(this.itemsTarget)
    console.log(this.formTarget)
  }
}
