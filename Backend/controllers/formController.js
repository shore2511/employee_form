// const Form = require("../models/Form");

// exports.searchForm = async (req, res) => {
//   try {
//     const {
//       employeeId,
//       name,
//       empTypes,
//       gender,
//       subject1,
//       subject2,
//       subject3,
//       subject4,
//       subject5,
//     } = req.query;

//     // Create a filter object
//     let filter = {};

//     // Exact match for Employee ID
//     if (employeeId) {
//       filter.employeeId = employeeId;
//     }

//     // Partial match for Name
//     if (name) {
//       filter.name = name;
//     }
//     if (gender) {
//       filter.gender = gender;
//     }

//     // Filter by empTypes
//     if (empTypes) {
//       filter.empTypes = empTypes;
//     }

//     if (subject1) {
//       filter.subject1 = subject1;
//     }
//     if (subject2) {
//       filter.subject2 = subject2;
//     }
//     if (subject3) {
//       filter.subject3 = subject3;
//     }
//     if (subject4) {
//       filter.subject4 = subject4;
//     }
//     if (subject5) {
//       filter.subject1 = subject5;
//     }

//     const forms = await Form.find(filter);

//     // No forms found
//     if (forms.length === 0) {
//       return res.status(404).json({
//         success: false,
//         message: "No data found for the provided filters",
//       });
//     }

//     // Success
//     res.status(200).json({
//       success: true,
//       data: forms,
//     });
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({
//       success: false,
//       message: "Internal server error",
//     });
//   }
// };

//Import the model
const Form = require("../models/Form");

exports.searchForm = async (req, res) => {
  try {
    const {
      employeeId,
      name,
      employmentType,
      gender,
      hindi,
      english,
      math,
      cs,
      sst,
    } = req.query;

    // Create a filter object
    let filter = {};

    // Exact match for Employee ID
    if (employeeId) {
      filter.employeeId = employeeId;
    }

    // Partial match for Name
    if (name) {
      filter.name = { $regex: name, $options: "i" }; // Updated to support partial match (case-insensitive)
    }

    if (gender) {
      filter.gender = gender;
    }

    // Filter by employmentType
    if (employmentType) {
      filter.employmentType = employmentType;
    }

    // Filtering by marks
    if (hindi) {
      filter["marks.hindi"] = hindi;
    }
    if (english) {
      filter["marks.english"] = english;
    }
    if (math) {
      filter["marks.math"] = math;
    }
    if (cs) {
      filter["marks.cs"] = cs;
    }
    if (sst) {
      filter["marks.sst"] = sst;
    }

    const forms = await Form.find(filter);

    // No employees found
    if (forms.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No data found for the provided filters",
      });
    }

    // Success
    res.status(200).json({
      success: true,
      data: employees,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};
