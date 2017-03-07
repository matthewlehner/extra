const ExtractTextPlugin = require("extract-text-webpack-plugin");
const ExtractSVGPlugin = require("svg-sprite-loader/lib/extract-svg-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const webpack = require("webpack");
const merge = require("webpack-merge");

let extractCSS = new ExtractTextPlugin("css/[name].css");
let extractSVG = new ExtractSVGPlugin("images/[name].svg");

let common = {
  entry: {
    "app": [
      "./web/static/css/app.scss",
      "./web/static/js/app.js"
    ],
    "public": [
      "./web/static/css/public.scss",
      "./web/static/js/public/index.js"
    ],
    "marketing": [
      "./web/static/css/marketing.scss",
      "./web/static/js/marketing.js"
    ]
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
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        options: {
          presets: [
            "react",
            ["env", {
              "browsers": ["last 2 versions", "safari >= 7"],
              "modules": false
            }]
          ]
        }
      }, {
        test: /.*\.svg$/,
        exclude: /node_modules/,
        use: extractSVG.extract({
          use: [{
            loader: "svg-sprite-loader",
            options: {
              name: "[name]-icon",
              extract: true,
              esModule: false
            }
          }, {
            loader: "svgo-loader",
            options: {
              plugins: [
                {removeTitle: true}
              ]
            }
          }]
        })
      }, {
        test: /\.scss$/,
        exclude: /node_modules/,
        use: extractCSS.extract({
          fallback: "style-loader",
          use: [{
            loader: "css-loader",
            options: {
              sourceMap: true,
              importLoaders: 1
            }
          }, {
            loader:  "postcss-loader"
          }, {
            loader: "sass-loader",
            options: {
              sourceMap: true,
              includePaths: [__dirname + "/web/static/css"]
            }
          }]
        })
      }
    ]
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
          require("autoprefixer")()
          // require("postcss-browser-reporter")(),
          // require("postcss-reporter")()
        ]
      }
    }),
    new CopyWebpackPlugin([{
      from: { glob: "**/*", dot: false },
      context: "./web/static/assets"
    }]),
    extractCSS,
    extractSVG
  ]
};

let config;

switch (process.env.npm_lifecycle_event) {
  case "deploy":
    config = merge(common, {});
    break;
  default:
    config = merge(common, {
      module: {
        rules: [
          {
            test: /\.js$/,
            enforce: "pre",
            use: [{
              loader: "eslint-loader"
            }]
          },
        ]
      },
      devtool: "source-map"
    });
}

module.exports = config;
