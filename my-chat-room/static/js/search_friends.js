const searchInput = document.getElementById("search");

searchInput.addEventListener("input", function () {
  const searchText = searchInput.value.toLowerCase();
  const contactList = document.getElementsByClassName("messaging-member");

  for (let i = 0; i < contactList.length; i++) {
    const contact = contactList[i];
    const searchData = contact.getAttribute("data-search").toLowerCase();

    if (searchData.includes(searchText)) {
      contact.style.display = "block";
    } else {
      contact.style.display = "none";
    }
  }
});
