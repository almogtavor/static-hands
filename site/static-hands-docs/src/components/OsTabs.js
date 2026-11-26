import React, { useEffect, useState } from "react";
import clsx from "clsx";
import useBaseUrl from "@docusaurus/useBaseUrl";
import styles from "./OsTabs.module.css";

const LABELS = { windows: "Windows", mac: "macOS" };

function detectOs() {
  if (typeof navigator === "undefined") {
    return null;
  }
  const platform =
    (navigator.userAgentData && navigator.userAgentData.platform) ||
    navigator.platform ||
    navigator.userAgent ||
    "";
  if (/mac/i.test(platform)) {
    return "mac";
  }
  if (/win/i.test(platform)) {
    return "windows";
  }
  return null;
}

/**
 * Tabs that open on the visitor's operating system.
 * The server renders the first tab; the browser switches to the detected OS
 * right after load. Clicking a tab always wins over detection.
 */
export default function OsTabs({ children }) {
  const tabs = React.Children.toArray(children).filter(
    (child) => child.props && child.props.os
  );
  const [active, setActive] = useState(tabs[0].props.os);
  const [detected, setDetected] = useState(null);

  useEffect(() => {
    const os = detectOs();
    if (os && tabs.some((tab) => tab.props.os === os)) {
      setDetected(os);
      setActive(os);
    }
  }, []);

  return (
    <div className={styles.osTabs}>
      <ul className="tabs" role="tablist" aria-label="Operating system">
        {tabs.map((tab) => {
          const os = tab.props.os;
          return (
            <li
              key={os}
              role="tab"
              tabIndex={0}
              aria-selected={active === os}
              className={clsx("tabs__item", styles.tab, {
                "tabs__item--active": active === os,
              })}
              onClick={() => setActive(os)}
              onKeyDown={(event) => {
                if (event.key === "Enter" || event.key === " ") {
                  event.preventDefault();
                  setActive(os);
                }
              }}
            >
              {LABELS[os] || os}
              {detected === os && (
                <span className={styles.detected}>your computer</span>
              )}
            </li>
          );
        })}
      </ul>
      {tabs.map((tab) => (
        <div
          key={tab.props.os}
          role="tabpanel"
          hidden={active !== tab.props.os}
          className={styles.panel}
        >
          {tab.props.children}
        </div>
      ))}
    </div>
  );
}

export function OsTab({ children }) {
  return <>{children}</>;
}

/** Big download button. `to` is a full URL or a path inside /static. */
export function DownloadButton({ to, children }) {
  const baseUrl = useBaseUrl(to);
  const href = /^https?:/.test(to) ? to : baseUrl;
  return (
    <p>
      <a className="button button--primary button--lg" href={href}>
        {children}
      </a>
    </p>
  );
}

/** A setup illustration from /static/img. */
export function Shot({ src, alt }) {
  return (
    <img
      className={styles.shot}
      src={useBaseUrl(`/img/${src}`)}
      alt={alt}
      loading="lazy"
    />
  );
}
