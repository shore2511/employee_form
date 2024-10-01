// // //Bussiness logic are written here

// // import the model
// const Form = require("../models/Form");

// // create a new Form item
// exports.updateForm = async (req, res) => {
//   try {
//     const { id } = req.params;
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

//     const form = await Form.findByIdAndUpdate(
//       { _id: id },
//       {
//         employeeId,
//         Name,
//         empTypes,
//         email,
//         gender,
//         phoneNumber,
//         subject1,
//         subject2,
//         subject3,
//         subject4,
//         subject5,
//         updatedAt: Date.now(),
//       }
//     );
//     //send the json response with a succes flag
//     res.status(200).json({
//       success: true,
//       data: form,
//       message: "updated Successfully",
//     });
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({
//       success: false,
//       error: err.message,
//       message: "Server Error",
//     });
//   }
// };

// Import the model
const Form = require("../models/Form");

// Update an existing Form item
exports.updateForm = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      employeeId,
      name,
      employmentType,
      email,
      gender,
      phoneNumber,
      hindi,
      english,
      math,
      cs,
      sst,
    } = req.body;

    // Find and update the employee by ID
    const form = await Form.findByIdAndUpdate(
      { _id: id },
      {
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
        updatedAt: Date.now(), // Ensures the updatedAt field is set correctly
      },
      { new: true } // Return the updated document
    );

    // Check if the employee was found and updated
    if (!form) {
      return res.status(404).json({
        success: false,
        message: "Employee not found",
      });
    }

    // Send the JSON response with a success flag
    res.status(200).json({
      success: true,
      data: form,
      message: "Updated Successfully",
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      success: false,
      error: err.message,
      message: "Server Error",
    });
  }
};
