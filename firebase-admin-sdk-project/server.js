const express = require('express');
const admin = require('firebase-admin');
const bodyParser = require('body-parser');
const serviceAccount = require('./tripplanner3-e7465-firebase-adminsdk-8x8ni-d7f4de7ac3.json');

// Initialize the Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const app = express();
app.use(bodyParser.json());

// Route to update email
app.post('/update-email', async (req, res) => {
  const { uid, newEmail } = req.body;

  try {
    // Update user's email in Firebase
    await admin.auth().updateUser(uid, {
      email: newEmail
    });

    res.status(200).send('Email updated successfully!');
  } catch (error) {
    console.error('Error updating email:', error);
    res.status(500).send('Failed to update email.');
  }
});

// Start the server on port 3000
const port = 3000;
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
