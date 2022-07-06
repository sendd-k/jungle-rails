describe("Testing adding to cart", () => {
  it("Can add cart on click", () => {
    cy.visit("http://localhost:3000");
    cy.get(".products article:first").find(".button_to").submit();
    cy.get(".nav-item.end-0").find(".nav-link").contains("1");
  });
});
