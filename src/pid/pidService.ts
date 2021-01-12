import axios from "axios";
export interface PidData {
    "URL": string;
    "type": string;
    "persist": string;
}
export interface PidHeader {
    "Content-Type": string;
    "apikey": string;
}

export const pidHeader: PidHeader = {"Content-Type": "application/json", "apikey": process.env.PID_KEY};

// axios.interceptors.request.use(request => {
//     console.log("Starting Request", JSON.stringify(request, undefined, 2));
//     return request;
//   });
export async function getPid(url: string) {
    try {
        // const config: AxiosRequestConfig
        const data: PidData = {"URL": url, "type": "URN", "persist": "1"};
        const response = await axios.post(process.env.PID_SERVICE_URL, data, {"headers": pidHeader});
        return response.data;
    }
    catch (error) {
        console.error(error);
    }
}