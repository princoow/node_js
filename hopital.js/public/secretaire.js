document.getElementById('add-patient-form').addEventListener('submit', function (e) {
    e.preventDefault();
    addPatient();
});

function addPatient() {
    const nom = document.getElementById('nom').value;
    const prenom = document.getElementById('prenom').value;
    const rdvDate = document.getElementById('rdv-date').value;

    const table = document.getElementById('appointment-table');
    const row = table.insertRow();
    row.insertCell(0).innerText = nom;
    row.insertCell(1).innerText = prenom;
    row.insertCell(2).innerText = rdvDate;
    const actionsCell = row.insertCell(3);
    actionsCell.className = 'actions';
    actionsCell.innerHTML = '<button onclick="editAppointment(this)">Modifier</button><button onclick="deleteAppointment(this)">Supprimer</button>';
}

function editAppointment(button) {
    const row = button.parentNode.parentNode;
    const nom = row.cells[0].innerText;
    const prenom = row.cells[1].innerText;
    const rdvDate = row.cells[2].innerText;

    document.getElementById('nom').value = nom;
    document.getElementById('prenom').value = prenom;
    document.getElementById('rdv-date').value = rdvDate;

    row.remove();
}

function deleteAppointment(button) {
    const row = button.parentNode.parentNode;
    row.remove();
}
