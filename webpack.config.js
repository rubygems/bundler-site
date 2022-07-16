const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  mode: 'development',
  entry: {
    application: ['./assets/javascripts/application.js', './assets/stylesheets/application.css.scss'],
    anchors: ['./assets/javascripts/anchors.js'],
    commands_layout: ['./assets/javascripts/commands_layout.js'],
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
          MiniCssExtractPlugin.loader,
          'css-loader',
          'sass-loader',
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
