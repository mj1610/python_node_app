const express = require("express");
const path = require("path");
const bodyParser = require("body-parser");
const axios = require("axios");

const app = express();
const port = 3000;

// here dotenv is not required as we are using kubernetes and environment variables are set in the deployment files
// const dotenv = require("dotenv");
// dotenv.config();
const backendUrl = process.env.BACKEND_URL || "http://localhost:8000";

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.static(path.join(__dirname, "public")));
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.get("/", (req, res) => {
  res.render("form");
});

//Submit form data to the backend
app.post("/submit", async (req, res) => {
  try {
    const response = await axios.post(`${backendUrl}/submit`, req.body);
    if (response.data.status === "success") {
      res.render("success", { message: "Data submitted successfully!" });
    } else {
      res.render("form", { error: "Unknown error occurred at backend" });
    }
  } catch (error) {
    res.render("form", { error: error.message });
  }
});

// Fetch data from the backend API
app.get("/api", async (req, res) => {
  try {
    const response = await axios.get(`${backendUrl}/api`);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.listen(port, () => {
  console.log(`Frontend running at http://localhost:${port}`);
});
