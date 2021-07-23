import React from "react";
import clsx from "clsx";
import styles from "./HomepageFeatures.module.css";

const FeatureList = [
  {
    title: "Easy to Use",
    Svg: require("../../static/img/undraw_docusaurus_mountain.svg").default,
    description: (
      <>
        Static Hands was designed from the ground up to be easily installed and
        used to let you speed up your developing time.
      </>
    ),
  },
  {
    title: "Speed Yourself Up",
    Svg: require("../../static/img/undraw_docusaurus_tree.svg").default,
    description: (
      <>
        Minimal shortcuts using the CapsLock key that doesn't require moving
        hands. Lets you get to every key in your keyboard, like it in the middle
        of it.
      </>
    ),
  },
  {
    title: "New Typing Features",
    Svg: require("../../static/img/undraw_docusaurus_react.svg").default,
    description: (
      <>
        Keep windows on top, move 6 words on each tap, turn a string upper or
        lower and more.
      </>
    ),
  },
];

function Feature({ Svg, title, description }) {
  return (
    <div className={clsx("col col--4")}>
      <div className="text--center">
        <Svg className={styles.featureSvg} alt={title} />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
