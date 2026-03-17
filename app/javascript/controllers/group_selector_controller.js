import { Controller } from "@hotwired/stimulus";
import { Modal } from "bootstrap";

export default class extends Controller {
  static targets = [
    "input",
    "checkbox",
    "summary",
    "count",
    "search",
    "groupItem",
    "userInput",
    "userCheckbox",
    "userSummary",
    "userCount",
    "userSearch",
    "userItem",
  ];

  connect() {
    this.groupModal = new Modal(document.getElementById("groupsModal"));
    this.userModal = new Modal(document.getElementById("usersModal"));
    this.currentGroupInput = null;
    this.currentGroupSummary = null;
    this.currentGroupCount = null;
    this.currentUserInput = null;
    this.currentUserSummary = null;
    this.currentUserCount = null;
  }

  // ---- GRUPPI (per voce) ----

  open(event) {
    event.preventDefault();

    const row = event.target.closest(".nested-fields");
    this.currentGroupInput = row.querySelector(
      "[data-group-selector-target='input']",
    );
    this.currentGroupSummary = row.querySelector(
      "[data-group-selector-target='summary']",
    );
    this.currentGroupCount = row.querySelector(
      "[data-group-selector-target='count']",
    );

    const selected = (this.currentGroupInput.value || "")
      .split(",")
      .filter(Boolean);
    this.checkboxTargets.forEach(
      (cb) => (cb.checked = selected.includes(cb.value)),
    );

    this.searchTarget.value = "";
    this.groupItemTargets.forEach((el) => (el.style.display = ""));

    this._updateGroupCount();
    this.groupModal.show();
  }

  filter() {
    const q = this.searchTarget.value.toLowerCase();
    this.groupItemTargets.forEach((el) => {
      el.style.display = el.dataset.name.includes(q) ? "" : "none";
    });
  }

  change() {
    this._updateGroupCount();
    this._updateGroupSummary();
  }

  save(event) {
    event.preventDefault();
    this._updateGroupSummary();
    this.groupModal.hide();
  }

  // ---- UTENTI (per voce) ----

  openUsers(event) {
    event.preventDefault();

    const row = event.target.closest(".nested-fields");
    this.currentUserInput = row.querySelector(
      "[data-group-selector-target='userInput']",
    );
    this.currentUserSummary = row.querySelector(
      "[data-group-selector-target='userSummary']",
    );
    this.currentUserCount = row.querySelector(
      "[data-group-selector-target='userCount']",
    );

    const selected = (this.currentUserInput.value || "")
      .split(",")
      .filter(Boolean);
    this.userCheckboxTargets.forEach(
      (cb) => (cb.checked = selected.includes(cb.value)),
    );

    this.userSearchTarget.value = "";
    this.userItemTargets.forEach((el) => (el.style.display = ""));

    this._updateUserCount();
    this.userModal.show();
  }

  filterUsers() {
    const q = this.userSearchTarget.value.toLowerCase();
    this.userItemTargets.forEach((el) => {
      el.style.display = el.dataset.name.includes(q) ? "" : "none";
    });
  }

  changeUser() {
    this._updateUserCount();
    this._updateUserSummary();
  }

  saveUsers(event) {
    event.preventDefault();
    this._updateUserSummary();
    this.userModal.hide();
  }

  // ---- Privati Gruppi ----

  _updateGroupCount() {
    if (!this.currentGroupCount) return;
    const count = this.checkboxTargets.filter((cb) => cb.checked).length;
    this.currentGroupCount.textContent =
      count > 0 ? `${count} gruppi selezionati` : "";
  }

  _updateGroupSummary() {
    if (!this.currentGroupInput || !this.currentGroupSummary) return;
    const selected = this.checkboxTargets.filter((cb) => cb.checked);
    this.currentGroupInput.value = selected.map((cb) => cb.value).join(",");
    const names = selected.map((cb) => cb.dataset.name).filter(Boolean);
    this.currentGroupSummary.textContent =
      names.length > 0 ? names.join(", ") : "Nessun gruppo";
  }

  // ---- Privati Utenti ----

  _updateUserCount() {
    if (!this.currentUserCount) return;
    const count = this.userCheckboxTargets.filter((cb) => cb.checked).length;
    this.currentUserCount.textContent =
      count > 0 ? `${count} utenti selezionati` : "";
  }

  _updateUserSummary() {
    if (!this.currentUserInput || !this.currentUserSummary) return;
    const selected = this.userCheckboxTargets.filter((cb) => cb.checked);
    this.currentUserInput.value = selected.map((cb) => cb.value).join(",");
    const names = selected.map((cb) => cb.dataset.name).filter(Boolean);
    this.currentUserSummary.textContent =
      names.length > 0 ? names.join(", ") : "Nessun utente";
  }
}
