using NUnit.Framework;

using Application;

namespace ApplicationTests
{
    public class DummyTests
    {
        [Test]
        public void Given_ValidDummy_When_ValueIsRead_Then_CorrectValueIsProvided()
        {
            // Arrange
            const int expectedResult = 8;

            var o = new Dummy();

            // Act
            var result = o.GetValue();

            // Assert
            Assert.AreEqual(expectedResult, result);
            Assert.Ignore();
        }
    }
}
