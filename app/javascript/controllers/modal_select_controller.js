import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "groupSearch",
    "userSearch",
    "groupItem",
    "userItem",
    "groupCheckbox",
    "userCheckbox",
    "groupsSummary",
    "usersSummary",
    "groupsCount",
    "usersCount",
  ];

  // ---- Inizializzazione: aggiorna i riepiloghi al caricamento ----
  connect() {
    this._updateSummary(
      this.groupCheckboxTargets,
      this.groupsSummaryTarget,
      "Nessun gruppo selezionato",
    );
    this._updateSummary(
      this.userCheckboxTargets,
      this.usersSummaryTarget,
      "Nessun utente selezionato",
    );
  }

  // ---- Ricerca live ----
  filterGroups() {
    const q = this.groupSearchTarget.value.toLowerCase();
    this.groupItemTargets.forEach((el) => {
      el.style.display = el.dataset.name.includes(q) ? "" : "none";
    });
  }

  filterUsers() {
    const q = this.userSearchTarget.value.toLowerCase();
    this.userItemTargets.forEach((el) => {
      el.style.display = el.dataset.name.includes(q) ? "" : "none";
    });
  }

  // ---- Aggiorna conteggio E riepilogo ad ogni cambio checkbox ----
  updateGroupsCount() {
    this._updateCount(
      this.groupCheckboxTargets,
      this.groupsCountTarget,
      "gruppi",
    );
    this._updateSummary(
      this.groupCheckboxTargets,
      this.groupsSummaryTarget,
      "Nessun gruppo selezionato",
    );
  }

  updateUsersCount() {
    this._updateCount(
      this.userCheckboxTargets,
      this.usersCountTarget,
      "utenti",
    );
    this._updateSummary(
      this.userCheckboxTargets,
      this.usersSummaryTarget,
      "Nessun utente selezionato",
    );
  }

  // ---- Apertura modale: aggiorna conteggio ----
  groupsModalOpened() {
    this._updateCount(
      this.groupCheckboxTargets,
      this.groupsCountTarget,
      "gruppi",
    );
  }

  usersModalOpened() {
    this._updateCount(
      this.userCheckboxTargets,
      this.usersCountTarget,
      "utenti",
    );
  }

  confirmGroups(event) {
    // Remove old hidden fields
    const container = document.getElementById("group-hidden-fields");
    container.innerHTML = "";

    // Add blank one first (Rails convention for empty arrays)
    const blank = document.createElement("input");
    blank.type = "hidden";
    blank.name = "user[group_ids][]";
    blank.value = "";
    container.appendChild(blank);

    // Add one hidden field per checked group
    this.groupCheckboxTargets
      .filter((cb) => cb.checked)
      .forEach((cb) => {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "user[group_ids][]";
        input.value = cb.value;
        container.appendChild(input);
      });

    this._updateSummary(
      this.groupCheckboxTargets,
      this.groupsSummaryTarget,
      "Nessun gruppo selezionato",
    );
  }

  // ---- Privati ----
  _updateCount(checkboxes, countEl, label) {
    const count = checkboxes.filter((cb) => cb.checked).length;
    countEl.textContent = count > 0 ? `${count} ${label} selezionati` : "";
  }

  _updateSummary(checkboxes, summaryEl, emptyText) {
    const names = checkboxes
      .filter((cb) => cb.checked)
      .map((cb) => cb.dataset.name)
      .filter(Boolean);
    summaryEl.textContent = names.length > 0 ? names.join(", ") : emptyText;
  }
}
