module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'prettier', // prettier와 충돌 방지
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: ['react', 'react-hooks', 'prettier'],
  rules: {
    'prettier/prettier': 'warn',
    'react/react-in-jsx-scope': 'off', // React 17+에선 필요 없음
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
};