var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");
var webpack = require("webpack");

module.exports = {
  entry: {
    "app": ["./web/static/css/app.scss", "./web/static/js/app.js"],
    "public": "./web/static/css/public.scss"
  },

  output: {
    path: "./priv/static",
    filename: "js/[name].js"
  },

  resolve: {
    modules: [
      "node_modules",
      __dirname + "/web/static/js"
    ]
  },

  module: {
    rules: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: "babel",
      options: {
        presets: ["es2016", ["es2015", {"modules": false}]]
      }
    }, {
      test: /\.scss$/,
      loader: ExtractTextPlugin.extract({
        fallbackLoader: "style-loader",
        loader: [{
          loader: "css-loader?sourceMap",
          options: { importLoaders: 1 }
        },{
          loader: "postcss-loader"
        },{
          loader: "sass-loader",
          options: {
            includePaths: [__dirname + "/web/static/css"]
          }
        }]
      })
    }]
  },

  plugins: [
    new webpack.LoaderOptionsPlugin({
      options: {
        context: __dirname + "/web/static/js",
        postcss: [
          // require("postcss-smart-import")({
          //   from: "./web/static/css/",
          //   plugins: [ require("stylelint")() ]
          // }),
          // require("postcss-url")(),
          // require("postcss-cssnext"),
          require('autoprefixer')({browsers: ["> 5%"]})
          // require("postcss-browser-reporter")(),
          // require("postcss-reporter")()
        ]
      }
    }),
    new ExtractTextPlugin("css/[name].css"),
    new CopyWebpackPlugin([{ from: "./web/static/assets" }])
  ],

  devtool: "source-map"
};
