import "./scss/home.scss";
import Card from "@mui/material/Card";
import CardActions from "@mui/material/CardActions";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";

import Web3 from "web3";
import ABI from "../kiln/ABI.json";

const web3 = new Web3("http://localhost:8545");
const contractAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const contract = new web3.eth.Contract(ABI, contractAddress);

// async function createAgreementAndLog() {
//   try {
//     const result = await contract.methods.createAgreement(
//       "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266",
//       "0x70997970C51812dc3A010C7d01b50e0d17dc79C8",
//       "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC",
//       1
//     ).call();
//     console.log(result);
//   } catch (error) {
//     console.error(error);
//   }
// }

contract.methods.createAgreement("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266",
								 "0x70997970C51812dc3A010C7d01b50e0d17dc79C8",
								 "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC", 1).call()
									.then((result: number) => { console.log(result);})
									.catch((error: any) => { console.log(error);});
	// <div>
	// 	<button onClick={async () => { await createAgreementAndLog();}}> test</button>
	// </div>
console.log(ABI);

export default function Home() {
  return (

    <div className="home">
      <div className="home__box">available escroc contracts</div>
      <div className="home__box">
        <div className="contract">
          <Card sx={{ maxWidth: 345 }}>
            <CardMedia
              sx={{ height: 140 }}
              image="/static/images/cards/contemplative-reptile.jpg"
              title="green iguana"
            />
            <CardContent>
              <Typography gutterBottom variant="h5" component="div">
                Scale AI
              </Typography>
              <Typography variant="body2" sx={{ color: "text.secondary" }}>
                Lorem ipsum dolor sit amet consectetur adipisicing elit.
                Nostrum, illo debitis! Ducimus consequatur voluptate
              </Typography>
            </CardContent>
            <CardActions>
              <Button size="small">Details</Button>
              <Button size="small">validate</Button>
            </CardActions>
          </Card>
        </div>
        <div className="contract">
          <Card sx={{ maxWidth: 345 }}>
            <CardMedia
              sx={{ height: 140 }}
              image="/static/images/cards/contemplative-reptile.jpg"
              title="green iguana"
            />
            <CardContent>
              <Typography gutterBottom variant="h5" component="div">
                Tesla
              </Typography>
              <Typography variant="body2" sx={{ color: "text.secondary" }}>
                Lorem ipsum dolor sit amet consectetur adipisicing elit.
                Nostrum, illo debitis! Ducimus consequatur voluptate
              </Typography>
            </CardContent>
            <CardActions>
              <Button size="small">Details</Button>
              <Button size="small">validate</Button>
            </CardActions>
          </Card>
        </div>
        <div className="contract">
          <Card sx={{ maxWidth: 345 }}>
            <CardMedia
              sx={{ height: 140 }}
              image="/static/images/cards/contemplative-reptile.jpg"
              title="green iguana"
            />
            <CardContent>
              <Typography gutterBottom variant="h5" component="div">
                Kiln
              </Typography>
              <Typography variant="body2" sx={{ color: "text.secondary" }}>
                Lorem ipsum dolor sit amet consectetur adipisicing elit.
                Nostrum, illo debitis! Ducimus consequatur voluptate
              </Typography>
            </CardContent>
            <CardActions>
              <Button size="small">Details</Button>
              <Button size="small">validate</Button>
            </CardActions>
          </Card>
        </div>
      </div>
    </div>
  );
}
