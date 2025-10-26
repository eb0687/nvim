export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "chore", "docs", "style", "refactor", "perf", "test"],
    ],
    "type-empty": [0, "always"],
    "subject-case": [2, "never", ["start-case", "pascal-case", "upper-case"]],
  },
};
