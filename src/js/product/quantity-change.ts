import SelectorsMap from '../constants/selectors-map';

export function detectQuantityChange(prestashop: any) {
  const quantityInput = document.querySelector(
    SelectorsMap.qtyInput.quantityWanted,
  ) as HTMLInputElement;
  const incrementButton = document.querySelector(
    SelectorsMap.qtyInput.increment,
  ) as HTMLButtonElement;
  const decrementButton = document.querySelector(
    SelectorsMap.qtyInput.decrement,
  ) as HTMLButtonElement;

  if (quantityInput && incrementButton && decrementButton) {
    const triggerEmit = () => {
      const inputValue = parseInt(quantityInput.value, 10);
      const minValue = parseInt(quantityInput.min, 10);
      if (!isNaN(inputValue) && inputValue >= minValue) {
        quantityInput.value = inputValue.toString();
      } else {
        quantityInput.value = minValue.toString();
      }
      prestashop.emit('updateProduct', {
        eventType: 'updatedProductQuantity',
      });
    };
    quantityInput.addEventListener('change', triggerEmit);
    incrementButton.addEventListener('click', triggerEmit);
    decrementButton.addEventListener('click', triggerEmit);
  }
}