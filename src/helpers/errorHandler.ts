export class ErrorHandler extends Error {
    statusCode: string;
    constructor(statusCode, message) {
      super();
      this.statusCode = statusCode;
      this.message = message;
    }
  }

export const genericErrorMessage = "Palvelussamme on tällä hetkellä vikatilanne. Selvitämme ongelmaa ja korjaamme sen mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.";
export const handleError = (err, res) => {
    let { statusCode } = err;
    let { message } = err;
    console.error(err);
    // send generic error message
    message = genericErrorMessage;
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