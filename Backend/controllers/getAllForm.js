// import the model
// const Form = require("../models/Form");

// exports.getAllForm = async (req, res) => {
//   try {
//     // Extract parameters from the request
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
//     } = req.params;

//     // Construct the query
//     const query = {
//       $or: [
//         { _id: id },
//         { employeeId: employeeId },
//         { Name: Name },
//         { email: email },
//         { gender: gender },
//         { phoneNumber: phoneNumber },
//         { empTypes: empTypes },
//         { subject1: subject1 },
//         { subject2: subject2 },
//         { subject3: subject3 },
//         { subject4: subject4 },
//         { subject5: subject5 },
//       ],
//     };

//     // Find documents based on the query
//     const forms = await Form.find(query);

//     // Data not found
//     if (forms.length === 0) {
//       return res.status(404).json({
//         success: false,
//         message: "No Data Found with Given Criteria",
//       });
//     }

//     // Data found
//     res.status(200).json({
//       success: true,
//       data: forms,
//       message: "Forms data successfully fetched",
//     });
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({
//       success: false,
//       data: "Internal Server Error",
//       message: err.message,
//     });
//   }
// };

// Import the model
const Form = require("../models/Form");

exports.getAllForm = async (req, res) => {
  try {
    // Extract parameters from the request
    const {
      id,
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
    } = req.params;

    // Construct the query
    const query = {
      $or: [
        { _id: id },
        { employeeId: employeeId },
        { name: name },
        { email: email },
        { gender: gender },
        { phoneNumber: phoneNumber },
        { employmentType: employmentType },
        { "marks.hindi": hindi },
        { "marks.english": english },
        { "marks.math": math },
        { "marks.cs": cs },
        { "marks.sst": sst },
      ],
    };

    // Find documents based on the query
    const forms = await Form.find(query);

    // Data not found
    if (forms.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No Data Found with Given Criteria",
      });
    }

    // Data found
    res.status(200).json({
      success: true,
      data: forms,
      message: "forms data successfully fetched",
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      success: false,
      data: "Internal Server Error",
      message: err.message,
    });
  }
};
