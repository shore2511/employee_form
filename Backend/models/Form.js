// const mongoose = require("mongoose");

// const formSchema = new mongoose.Schema({
//   employeeId: {
//     type: String,
//     required: true,
//     maxLength: 50,
//     unique: true,
//   },
//   Name: {
//     type: String,
//     required: true,
//     maxLength: 100,
//   },
//   gender: {
//     type: String,
//     required: true,
//     enum: ["Male", "Female"], // Ensures the value is one of the allowed departments
//   },
//   empTypes: {
//     type: String,
//     required: true,
//     enum: ["Rugular", "Adhoc"], // Ensures the value is one of the allowed departments
//   },
//   email: {
//     type: String,
//     required: true,
//   },
//   phoneNumber: {
//     type: Number,
//     required: true,
//   },
//   subject1: {
//     type: String,
//     require: false,
//   },
//   subject2: {
//     type: String,
//     require: false,
//   },
//   subject3: {
//     type: String,
//     require: false,
//   },
//   subject4: {
//     type: String,
//     require: false,
//   },
//   subject5: {
//     type: String,
//     require: false,
//   },
//   CreatedAt: {
//     type: Date,
//     require: true,
//     default: Date.now(),
//   },
//   updatedAt: {
//     type: Date,
//     require: true,
//     default: Date.now(),
//   },
// });

// module.exports = mongoose.model("Form", formSchema);

// Importing mongoose
const mongoose = require("mongoose");

// Defining the employee schema
const formSchema = new mongoose.Schema({
  employeeId: {
    type: String,
    required: true,
    unique: true,
    maxLength: 50, // Added maxLength to match the original structure
  },
  name: {
    type: String,
    required: true,
    maxLength: 100, // Added maxLength to match the original structure
  },
  employmentType: {
    type: String,
    enum: ["Regular", "Adhoc"], // Corrected enum values to match the original
    required: true,
  },
  gender: {
    type: String,
    enum: ["Male", "Female", "Other"], // Included 'Other' for flexibility
    required: true,
  },
  phoneNumber: {
    type: Number,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  CreatedAt: {
    type: Date,
    require: true,
    default: Date.now(),
  },
  updatedAt: {
    type: Date,
    require: true,
    default: Date.now(),
  },
  marks: {
    hindi: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },
    english: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },
    math: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },
    cs: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },
    sst: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },
  },
});

// Exporting the model
module.exports = mongoose.model("Form", formSchema);
