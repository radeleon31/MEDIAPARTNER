const toggleNavbar = () => {
  const navToggle = document.querySelector(".nav-toggle");
  if (navToggle) {
    const links = document.querySelector(".links");

    navToggle.addEventListener("click", function () {
      links.classList.toggle("show-links");
    });
  }
}

$(function(){
  $("a[rel='tooltip']").tooltip();
})

export { toggleNavbar };
