// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    autoDismiss: { type: Boolean, default: true },
    dismissDelay: { type: Number, default: 1200 },
  };

  static targets = ["progressBar"];

  connect() {
    if (this.autoDismissValue) {
      this.startDismissTimer();
    }

    // Animate progress bar
    if (this.hasProgressBarTarget) {
      this.animateProgressBar();
    }
  }

  startDismissTimer() {
    this.dismissTimer = setTimeout(() => {
      this.dismiss();
    }, this.dismissDelayValue);
  }

  animateProgressBar() {
    this.progressBarTarget.style.transition = `width ${this.dismissDelayValue}ms linear`;
    this.progressBarTarget.style.width = "0%";
  }

  dismiss() {
    // Add fade-out class for CSS animation
    this.element.classList.add("alert-fade-out");

    // Remove element after animation completes
    setTimeout(() => {
      this.element.remove();

      // Remove the flash message from the flash hash
      this.dispatchEvent("removed");
    }, 500); // Match this with CSS animation duration
  }

  disconnect() {
    // Clean up timer if component is disconnected before auto-dismiss
    if (this.dismissTimer) {
      clearTimeout(this.dismissTimer);
    }
  }

  dispatchEvent(name) {
    const event = new CustomEvent(`flash:${name}`, {
      bubbles: true,
      cancelable: true,
      detail: { element: this.element },
    });
    this.element.dispatchEvent(event);
  }
}
