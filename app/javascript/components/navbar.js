const toggleNavbar = () => {
  const navToggle = document.querySelector(".nav-toggle");
  if (navToggle) {
    const links = document.querySelector(".links");

    navToggle.addEventListener("click", function () {
      links.classList.toggle("show-links");
    });
  }
}
export { toggleNavbar };