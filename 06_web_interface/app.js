document.addEventListener("DOMContentLoaded", () => {
  const roleSelect = document.getElementById("roleSelect");
  //const patientsSection = document.getElementById("patients-section");
  const patientsCard = document.getElementById("card-patients");
  //const doctorsSection = document.getElementById("doctors-section");
  const doctorsCard = document.getElementById("card-doctors");
  //const appointmentsSection = document.getElementById("appointments-section");
  const appointmentsCard = document.getElementById("card-appointments");
  const treatmentsCard = document.getElementById("card-treatments");  
  const billingCard = document.getElementById("card-billing");  
  // Initial view setup
  updateViewByRole(roleSelect.value);

  // Event: Role change
  roleSelect.addEventListener("change", () => {
    const selectedRole = roleSelect.value;
    updateViewByRole(selectedRole);
    console.log(roleSelect.value);
  });

  // Event: Clicking the Patients card
  patientsCard?.addEventListener("click", () => {
    const currentRole = roleSelect.value;
    console.log(currentRole);
    // Only fetch if role has permission
    if (["hospital_admin", "doctor_user"].includes(currentRole)) {
    showSection("patients-section");  // ✅ hide others + clear rows
      fetchPatients();
    } else {
      hideAllSectionsAndClear();
    }
  });


  // Event: Clicking the Doctors card
  doctorsCard?.addEventListener("click", () => {
    const currentRole = roleSelect.value;
    console.log(currentRole);

    // Only fetch if role has permission
    if (["hospital_admin", "doctor_user"].includes(currentRole)) {
      showSection("doctors-section");   // ✅ hide others + clear rows
      fetchDoctors();
    } else {
      hideAllSectionsAndClear();
    }
  });  

  // Event: Clicking the Appointments card
  appointmentsCard?.addEventListener("click", () => {
    const currentRole = roleSelect.value;
    console.log(currentRole);
    // Only fetch if role has permission
    if (["hospital_admin", "doctor_user", "nurse_user"].includes(currentRole)) {
      showSection("appointments-section");   // ✅ hide others + clear rows
      fetchAppointments();
    } else {
      hideAllSectionsAndClear();
    }
  });  

  // Event: Clicking the Treatments card
  treatmentsCard?.addEventListener("click", () => {
    const currentRole = roleSelect.value;
    console.log(currentRole);
    // Only fetch if role has permission
    if (["hospital_admin", "doctor_user", "nurse_user"].includes(currentRole)) {
      showSection("treatments-section");   // ✅ hide others + clear rows
      fetchTreatments();
    } else {
      hideAllSectionsAndClear();
    }
  });  

  // Event: Clicking the Billing card
  billingCard?.addEventListener("click", () => {
    const currentRole = roleSelect.value;
    console.log(currentRole);
    // Only fetch if role has permission
    if (["hospital_admin", "billing_user"].includes(currentRole)) {
      showSection("billing-section");   // ✅ hide others + clear rows
      fetchBilling();
    } else {
      hideAllSectionsAndClear();
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

function hideAllSectionsAndClear() {
  document.querySelectorAll('.data-section').forEach(sec => {
    sec.style.display = 'none';
    const tbody = sec.querySelector('tbody');
    if (tbody) tbody.replaceChildren();
  });
}

function showSection(sectionId) {
  hideAllSectionsAndClear();
  const sec = document.getElementById(sectionId);
  if (sec) sec.style.display = 'block';
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

// Fetch appointments from the API
async function fetchAppointments() {
  console.log("Fetching appointments...");
  try {
    const response = await fetch("/api/appointments");
    const data = await response.json();
    console.log("Data received:", data);

    const tbody = document.querySelector("#appointments-table tbody");
    tbody.innerHTML = "";

    data.forEach(appointment => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${appointment.appointment_id}</td>
        <td>${appointment.patient_id}</td>
        <td>${appointment.doctor_id}</td>
        <td>${appointment.appointment_date.slice(0, 10)}</td>
        <td>${appointment.appointment_time}</td>
        <td>${appointment.reason_for_visit}</td>   
        <td>${appointment.status}</td>  
      `;
      tbody.appendChild(row);
    });
  } catch (error) {
    console.error("Error loading appointments:", error);
  }
}


// Fetch Treatments from the API
async function fetchTreatments() {
  console.log("Fetching treatments...");
  try {
    const response = await fetch("/api/treatments");
    const data = await response.json();
    console.log("Data received:", data);

    const tbody = document.querySelector("#treatments-table tbody");
    tbody.innerHTML = "";

    data.forEach(treatment => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${treatment.treatment_id}</td>
        <td>${treatment.appointment_id}</td>
        <td>${treatment.treatment_type}</td>
        <td>${treatment.description}</td>
        <td>${treatment.cost}</td>
        <td>${treatment.treatment_date.slice(0, 10)}</td>   
      `;
      tbody.appendChild(row);
    });
  } catch (error) {
    console.error("Error loading treatments:", error);
  }
}


// Fetch Billing Data from the API
async function fetchBilling() {
  console.log("Fetching billing data...");
  try {
    const response = await fetch("/api/billing");
    const data = await response.json();
    console.log("Data received:", data);

    const tbody = document.querySelector("#billing-table tbody");
    tbody.innerHTML = "";

    data.forEach(bill => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${bill.bill_id}</td>
        <td>${bill.patient_id}</td>
        <td>${bill.treatment_id}</td>
        <td>${bill.bill_date.slice(0,10)}</td>
        <td>${bill.amount}</td>        
        <td>${bill.payment_method}</td>  
        <td>${bill.payment_status}</td>   
      `;
      tbody.appendChild(row);
    });
  } catch (error) {
    console.error("Error loading billing data:", error);
  }
}