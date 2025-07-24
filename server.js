const express = require('express');
const admin = require('firebase-admin');
const bodyParser = require('body-parser');

// Load the Firebase Admin credentials from the service account key
const serviceAccount = require('./tripplanner3-e7465-firebase-adminsdk-8x8ni-d7f4de7ac3.json');

// Initialize Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const app = express();
const port = 3000;

app.use(bodyParser.json());  // To parse incoming JSON payloads

// Route to handle email updates
app.post('/update-email', (req, res) => {
  const { uid, newEmail } = req.body;  // Extract uid and newEmail from request body

  // Ensure both uid and newEmail are provided
  if (!uid || !newEmail) {
    return res.status(400).send('UID and new email must be provided');
  }

  // Update the user's email
  admin.auth().updateUser(uid, {
    email: newEmail
  })
  .then((userRecord) => {
    res.status(200).send(`Successfully updated user email: ${userRecord.email}`);
  })
  .catch((error) => {
    res.status(500).send(`Error updating user email: ${error.message}`);
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
