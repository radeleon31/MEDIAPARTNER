const openSearchBarOnClick = () => {
  const searchIcon = document.querySelector('.searchIcon');
  const clearIcon = document.querySelector('.clear');
  if (searchIcon && clearIcon ) {
    searchIcon.addEventListener('click', () => {
      document.querySelector('.search').classList.add("visible");
      document.querySelector('.clear').classList.add("visible");
      document.querySelector('.search').focus();
      document.querySelector('.searchIcon').classList.add("hide");
    });
    clearIcon.addEventListener('click', () => {
      document.querySelector('.searchIcon').classList.remove("hide");
      document.querySelector('.search').classList.remove("visible");
      document.querySelector('.clear').classList.remove("visible");
    });
  }
}

export { openSearchBarOnClick};
