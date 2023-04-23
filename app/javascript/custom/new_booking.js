if (typeof setupFormListeners !== "function") {
  const setupFormListeners = async () => {
    const form = document.getElementById("booking-form")
    if (form) {
      // We are on new_booking_path
      form.addEventListener("input", (event) => {
        const ownerFirstNameValue = document.getElementById(
          "booking_owner_first_name",
        ).value
        const ownerLastNameValue = document.getElementById(
          "booking_owner_last_name",
        ).value
        const petNameValue = document.getElementById("booking_pet_name").value
        const petTypeValue = document.getElementById(
          "booking_pet_type_id",
        ).value
        const durationValue = document.getElementById("booking_duration").value
        const dateValue = document.getElementById("booking_date").value
        const submitBtn = document.querySelector('input[type="submit"]')
        if (
          ownerFirstNameValue &&
          ownerLastNameValue &&
          petNameValue &&
          petTypeValue &&
          durationValue &&
          dateValue
        ) {
          submitBtn.disabled = false
          submitBtn.classList.remove("submit-btn-disabled")
          submitBtn.classList.add("bg-dark-blue")
          submitBtn.classList.add("pointer")
        } else {
          submitBtn.disabled = true
          submitBtn.classList.add("submit-btn-disabled")
          submitBtn.classList.remove("bg-dark-blue")
          submitBtn.classList.remove("pointer")
        }
      })

      const priceChangeHandler = async (event) => {
        const pet_type = parseInt(
          document.getElementById("booking_pet_type_id").value,
        )
        const duration = parseInt(
          document.getElementById("booking_duration").value,
        )

        if (pet_type && duration) {
          const resp = await fetch(
            `/pricing_engine/get_price?pet_type=${pet_type}&duration=${duration}`,
          )
          const { price } = await resp.json()
          document.getElementById("total-price").innerHTML = price
        } else {
          document.getElementById("total-price").innerHTML = `N/A`
        }
      }
      const petTypeInput = document.getElementById("booking_pet_type_id")
      const durationInput = document.getElementById("booking_duration")
      petTypeInput.addEventListener("input", priceChangeHandler)
      durationInput.addEventListener("input", priceChangeHandler)
    }
  }

  setupFormListeners()
}
