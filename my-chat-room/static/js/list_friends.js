let li_amigos = document.querySelectorAll(".messaging-member");
if (li_amigos) {
  li_amigos.forEach((item) => {
    item.addEventListener("click", () => {
      li_amigos.forEach((item) => {
        item.classList.remove("messaging-member--active");
      });

      item.classList.add("messaging-member--active");

      /**
       * Realizando solicitud HTTP
       */
      let id_amigo = item.getAttribute("id");
      amigo_seleccionado(id_amigo);
    });
  });
}

async function amigo_seleccionado(id_amigo) {
  /**
   * Importante, realizo una solicitud con axios, puedo retorna dicha
   * respuesta asi jsonify(respuesta_filtro_home)
   * pero es mejor retorna la respuesta de una vez a una vista y pinta dicha data.
   */
  try {
    const response = await axios.post("/mostrar-amigo-seleccionado", {
      id_amigo,
    });
    if (!response.status) {
      console.log(`HTTP error! status: ${response.status} 😭`);
    }

    const data_amigo = response.data;

    /**
     * Verificando si existe un elemento html con esta clase 'section_inmuebles_recientes'
     */
    /*const sectionRecientes = document.querySelector(
      ".section_inmuebles_recientes"
    );
    */

    /*
    if (sectionRecientes) {
      const divRespDataList = document.querySelectorAll(
        ".result_filter_data_home"
      );
      */

    // Eliminar cada elemento con la clase "result_filter_data_home"
    /* divRespDataList.forEach((divRespData) => {
        divRespData.remove();
      });
      */

    // Crear un nuevo elemento div para contener la data
    const divData = document.createElement("div");
    //divData.classList.add("result_filter_data_home", "mt-3");
    divData.innerHTML = data_amigo;

    // Insertar el div antes de la sección
    //sectionRecientes.parentNode.insertBefore(divData, sectionRecientes);
    // }
  } catch (error) {
    console.error(error);
  }
}
