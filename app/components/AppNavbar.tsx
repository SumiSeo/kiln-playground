import Link from "next/link";
import "../scss/AppNavBar.scss";

export default function AppNavbar() {
  return (
    <div className="nav">
      <div className="nav__kiln">
        <Link href=".">kiln</Link>
      </div>
      <div className="nav__link">
        <Link href="./markets4626">markets</Link>
      </div>
      <div className="nav__link">
        <Link href="./personal4626">personalisation</Link>
      </div>
    </div>
  );
}
