import "./scss/home.scss";
import Card from "@mui/material/Card";
import CardActions from "@mui/material/CardActions";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import Header from "./components/Header";
import ConnectButtonHeader from "./components/ConnectButtonHeader";
export default function Home() {
  return (
    <div>
      <div className="home">
        {/* <Header /> */}
        <ConnectButtonHeader />
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
    </div>
  );
}
