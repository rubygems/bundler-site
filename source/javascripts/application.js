// The navigation menu is hidden below 768px until the toggle button opens it.
const nav = document.querySelector(".site-nav");
const toggle = nav.querySelector(".site-nav-toggle");

toggle.addEventListener("click", () => {
  const open = nav.classList.toggle("is-open");
  toggle.setAttribute("aria-expanded", String(open));
});
