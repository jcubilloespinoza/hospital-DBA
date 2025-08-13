document.addEventListener("DOMContentLoaded", () => {
  const roleSelect = document.getElementById("roleSelect");
  const patientsSection = document.getElementById("patients-section");
  const patientsCard = document.getElementById("card-patients");
  const doctorsSection = document.getElementById("doctors-section");
  const doctorsCard = document.getElementById("card-doctors");

  // Initial view setup
  updateViewByRole(roleSelect.value);

  // Event: Role change
  roleSelect.addEventListener("change", () => {
    const selectedRole = roleSelect.value;
    updateViewByRole(selectedRole);
  });

  // Event: Clicking the Patients card
  patientsCard?.addEventListener("click", () => {
    const currentRole = roleSelect.value;

    // Only fetch if role has permission
    if (["hospital_admin", "doctor_user"].includes(currentRole)) {
      patientsSection.style.display = "block";
      fetchPatients();
    } else {
      patientsSection.style.display = "none";
    }
  });


  // Event: Clicking the Doctors card
  doctorsCard?.addEventListener("click", () => {
    const currentRole = roleSelect.value;

    // Only fetch if role has permission
    if (["hospital_admin", "doctor_user"].includes(currentRole)) {
      doctorsSection.style.display = "block";
      fetchDoctors();
    } else {
      doctorsSection.style.display = "none";
    }
  });  
});

// Role-based card visibility
function updateViewByRole(role) {
  const billingCard = document.getElementById("card-billing");
  const treatmentCard = document.getElementById("card-treatments");
  const appointmentCard = document.getElementById("card-appointments");
  const doctorCard = document.getElementById("card-doctors");
  const patientCard = document.getElementById("card-patients");

  [billingCard, treatmentCard, appointmentCard, doctorCard, patientCard].forEach(card => {
    if (card) card.style.display = "none";
  });

  switch (role) {
    case "hospital_admin":
      [billingCard, treatmentCard, appointmentCard, doctorCard, patientCard].forEach(card => {
        if (card) card.style.display = "block";
      });
      break;
    case "doctor_user":
      if (patientCard) patientCard.style.display = "block";
      if (appointmentCard) appointmentCard.style.display = "block";
      break;
    case "nurse_user":
      if (appointmentCard) appointmentCard.style.display = "block";
      if (treatmentCard) treatmentCard.style.display = "block";
      break;
    case "billing_user":
      if (billingCard) billingCard.style.display = "block";
      break;
  }
}

// Fetch patients from the API
async function fetchPatients() {
  console.log("Fetching patients...");
  try {
    const response = await fetch("/api/patients");
    const data = await response.json();
    console.log("Data received:", data);

    const tbody = document.querySelector("#patients-table tbody");
    tbody.innerHTML = "";

    data.forEach(patient => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${patient.patient_id}</td>
        <td>${patient.first_name} ${patient.last_name}</td>
        <td>${patient.date_of_birth.slice(0, 10)}</td>
        <td>${patient.gender}</td>
        <td>${patient.insurance_provider}</td>
      `;
      tbody.appendChild(row);
    });
  } catch (error) {
    console.error("Error loading patients:", error);
  }
}

// Fetch doctors from the API
async function fetchDoctors() {
  console.log("Fetching doctors...");
  try {
    const response = await fetch("/api/doctors");
    const data = await response.json();
    console.log("Data received:", data);

    const tbody = document.querySelector("#doctors-table tbody");
    tbody.innerHTML = "";

    data.forEach(doctor => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${doctor.doctor_id}</td>
        <td>${doctor.first_name} ${doctor.last_name}</td>
        <td>${doctor.specialization}</td>
        <td>${doctor.phone_number}</td>
        <td>${doctor.years_experience}</td>
        <td>${doctor.hospital_branch}</td>        
      `;
      tbody.appendChild(row);
    });
  } catch (error) {
    console.error("Error loading doctors:", error);
  }
}