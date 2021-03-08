
const showingMetrics = () => {

  const metricElements = document.querySelectorAll('[data-metric]')
  if (metricElements) {
    [...metricElements].forEach(element => {
      let text = element.textContent
      // element.addEventListener("mouseout", () => {
      //   element.textContent = text
      // });
      element.addEventListener("mouseover", () => {
        element.textContent = element.dataset.metric
        setTimeout(() => { element.textContent = text; }, 3000);
      });

    });
    
  }
} 

export { showingMetrics }