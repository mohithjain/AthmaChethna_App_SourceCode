const express = require('express');
const Appointment = require('../models/Appointment');
const router = express.Router();

// ✅ Create Appointment
router.post('/create', async (req, res) => {
    console.log("➡️ Incoming POST request to /api/appointments/create");
    console.log("📝 Request Body:", req.body);
    const { userId, name, usn, semester, department, reason } = req.body;
  
    try {

        if (!userId || !name || !usn || !semester || !department || !reason) {
            return res.status(400).json({ message: "Missing required fields" });
        }
      const newAppointment = new Appointment({
        userId,
        name,
        usn,
        semester,
        department,
        reason
      });
  

    await newAppointment.save();
    console.log("✅ Appointment saved to database:", newAppointment);
    res.status(201).json({ message: "Appointment created successfully", appointment: newAppointment });
  } catch (error) {
    console.error("❌ Error creating appointment:", error);
    res.status(500).json({ message: "Failed to create appointment", error: error.message });
  }
});

// ✅ Fetch Appointments by User ID
router.get('/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
    const appointments = await Appointment.find({ userId }).populate('counselorId', 'name username email');
    if (!appointments || appointments.length === 0) {
      return res.status(404).json({ message: "No appointments found for this user." });
    }

    res.status(200).json({ appointments });
  } catch (error) {
    console.error("❌ Error fetching appointments:", error);
    res.status(500).json({ message: "Failed to fetch appointments", error: error.message });
  }
});

// ✅ Update Appointment Status (e.g., mark as completed)
router.put('/:appointmentId', async (req, res) => {
  const { appointmentId } = req.params;
  const { status, notes } = req.body;

  try {
    const appointment = await Appointment.findById(appointmentId);
    if (!appointment) {
      return res.status(404).json({ message: "Appointment not found." });
    }

    appointment.status = status || appointment.status;
    appointment.notes = notes || appointment.notes;

    await appointment.save();
    res.status(200).json({ message: "Appointment updated successfully", appointment });
  } catch (error) {
    console.error("❌ Error updating appointment:", error);
    res.status(500).json({ message: "Failed to update appointment", error: error.message });
  }
});

module.exports = router;
