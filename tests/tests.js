
exports.defineAutoTests = function() {

	describe('API', function () {
		it("should exist", function() {
		  	expect(window.pgsidebar).toBeDefined();

		});

		it("should have show method, of type function", function() {
		  	expect(window.pgsidebar.show).toBeDefined();
		  	expect(typeof window.pgsidebar.show).toBe("function");
		});

		it("should have hide method, of type function", function() {
		  	expect(window.pgsidebar.hide).toBeDefined();
		  	expect(typeof window.pgsidebar.hide).toBe("function");
		});

	});


};

exports.defineManualTests = function(){};