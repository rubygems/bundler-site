const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  mode: 'development',
  entry: {
    application: ['./assets/javascripts/application.js', './assets/stylesheets/application.css.scss'],
    two_column_layout: ['./assets/javascripts/two_column_layout.js'],
  },
  output: {
    path: path.resolve(__dirname, '.tmp/dist'),
    filename: '[name].min.js',
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader
          },
          {
            loader: 'css-loader'
          },
          {
            loader: 'sass-loader',
            options: {
              sassOptions: {
                silenceDeprecations: ['mixed-decls', 'color-functions', 'global-builtin', 'import'],
              }
            }
          }
        ],
      },
      {
        test: /\.css$/,
        loader: 'style-loader',
      },
      {
        test: /\.otf$/,
        type: 'asset/resource',
        generator: {
          filename: 'font/[hash][ext][query]'
        },
      },
    ]
  },
  plugins: [
    new MiniCssExtractPlugin(),
  ],
};
