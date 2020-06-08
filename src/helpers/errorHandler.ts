export class ErrorHandler extends Error {
    statusCode: string;
    constructor(statusCode, message) {
      super();
      this.statusCode = statusCode;
      this.message = message;
    }
  }

export const handleError = (err, res) => {
    let { statusCode } = err;
    const { message } = err;
    console.error(err);
    if (!statusCode) {
        statusCode = "500";
    }
    res.status(statusCode).json({
      status: "error",
      statusCode,
      message
    });
};
// module.exports = {
//     ErrorHandler,
//     handleError
// };