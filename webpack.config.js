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
        test: /\.(woff|woff2|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader',
      },
      {
        test: /\.otf$/,
        use: {
          loader: 'url-loader?name=fonts/[name].[ext]',
        }
      },
      {
        test: /bootstrap\/(transition|button|tooltip|popover|dropdown|collapse)\.js$/,
        use: [
          {
            loader: 'imports-loader',
            options: {
              imports: [
                'default jquery jQuery'
              ]
            }
          }
        ]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin(),
  ],
};
