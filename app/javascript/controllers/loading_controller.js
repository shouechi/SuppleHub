import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner"]

  connect() {
    if (this.hasSpinnerTarget) {
      this.hide()
    }
  }

  check(event) {
    const form = event.currentTarget
    const inputs = form.querySelectorAll("textarea[required]")
    let allFilled = true
    inputs.forEach(input => {
      if (input.value.trim() === "") {
        allFilled = false
      }
    })
    if (!allFilled) {
      event.preventDefault()
      this.hide()
      alert("必須項目を入力してください")
    } else {
      this.show()
    }
  }

  show() {
    if (this.hasSpinnerTarget) this.spinnerTarget.classList.remove("hidden")
  }

  hide() {
    if (this.hasSpinnerTarget) this.spinnerTarget.classList.add("hidden")
  }
}
