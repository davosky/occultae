import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "template"];

  add(event) {
    event.preventDefault();

    const content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime(),
    );

    // Inserisce il contenuto (un <tr>) direttamente nel tbody
    this.containerTarget.insertAdjacentHTML("beforeend", content);
  }
}
