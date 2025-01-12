test_that("step_fft agrees with fft", {
  prices <- tsrecipes::prices

  prices_xf <- recipe(prices) %>%
    step_fft(ts) %>%
    prep() %>%
    bake(prices)

  ts1_step_fft <- prices_xf %>%
    select(starts_with("fft")) %>%
    .[1, ] %>%
    unlist(use.names = FALSE)

  ts1_fft <- fft(prices$ts[[1]])[1:4]

  expect_equal(ts1_step_fft, c(Re(ts1_fft), Im(ts1_fft)))
})
