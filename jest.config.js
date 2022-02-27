module.exports = {
  preset: "jest-expo",
  transformIgnorePatterns: [
    "node_modules/(?!rescript|((jest-)?react-native|@react-native(-community)?)|expo(nent)?|@expo(nent)?/.*|@expo-google-fonts/.*|react-navigation|@react-navigation/.*|@unimodules/.*|unimodules|sentry-expo|native-base|react-native-svg)"
  ],
  testMatch: [
    "<rootDir>/__tests__/**/*_test.bs.js"
  ],
  setupFilesAfterEnv: ["<rootDir>/jest.setup.ts"],
}