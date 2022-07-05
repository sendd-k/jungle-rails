describe("Testing product details", () => {
  it("Can click on product page", () => {
    cy.visit("http://localhost:3000");
    cy.get(".products article").first().click();
  });
});
