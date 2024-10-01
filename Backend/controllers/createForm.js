//Bussiness logic are written here

// // import the model
// const Form = require("../models/Form");

// // create a new todo item
// exports.createForm = async (req, res) => {
//   try {
//     //extract title and description from the request body
//     const {
//       employeeId,
//       Name,
//       empTypes,
//       email,
//       gender,
//       phoneNumber,
//       subject1,
//       subject2,
//       subject3,
//       subject4,
//       subject5,
//     } = req.body;
//     //create a new Form object and insert in DB
//     const response = await Form.create({
//       employeeId,
//       Name,
//       empTypes,
//       email,
//       gender,
//       phoneNumber,
//       subject1,
//       subject2,
//       subject3,
//       subject4,
//       subject5,
//     });

//     //send the json response with a succes flag
//     res.status(201).json({
//       success: true,
//       data: response,
//       message: "Entry Created Successfully",
//     });
//   } catch (err) {
//     console.err(err);
//     console.log(err);
//     res.status(500).json({
//       success: false,
//       data: "internal server error",
//       message: err.message,
//     });
//   }
// };

// Import the model
const Form = require("../models/Form"); // Ensure your model file name matches this

// Create a new employee entry
exports.createForm = async (req, res) => {
  try {
    // Extract fields from the request body
    const {
      employeeId,
      name,
      employmentType,
      email,
      gender,
      phoneNumber,
      marks: { hindi, english, math, cs, sst },
    } = req.body;

    // Create a new Employee object and insert it in the DB
    const response = await Form.create({
      employeeId,
      name,
      employmentType,
      email,
      gender,
      phoneNumber,
      marks: {
        hindi,
        english,
        math,
        cs,
        sst,
      },
    });

    // Send the JSON response with a success flag
    res.status(201).json({
      success: true,
      data: response,
      message: "Employee Entry Created Successfully",
    });
  } catch (err) {
    console.error(err); // Corrected from console.err to console.error
    res.status(500).json({
      success: false,
      data: "Internal server error",
      message: err.message,
    });
  }
};
