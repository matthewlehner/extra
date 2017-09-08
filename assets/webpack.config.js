const path = require("path");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const webpack = require("webpack");
const merge = require("webpack-merge");

const extractCSS = new ExtractTextPlugin("css/[name].css");

const common = {
  entry: {
    app: ["./js/app.js", "./css/app.scss"],
    public: ["./css/public.scss", "./js/public/index.js"],
    marketing: ["./css/marketing.scss", "./js/marketing.js"]
  },

  output: {
    path: path.join(__dirname, "../priv/static"),
    publicPath: "/",
    filename: "js/[name].js",
    chunkFilename: "js/[name]-[chunkhash].js"
  },

  resolve: {
    modules: ["node_modules", path.join(__dirname, "js")],
    extensions: [".js", ".jsx"]
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: "babel-loader"
      },
      {
        test: /\.(graphql|gql)$/,
        exclude: /node_modules/,
        loader: "graphql-tag/loader"
      },
      {
        test: /.*\.svg$/,
        exclude: /node_modules/,
        use: [
          {
            loader: "svg-sprite-loader"
          },
          {
            loader: "svgo-loader",
            options: {
              plugins: [{ removeTitle: true }]
            }
          }
        ]
      },
      {
        test: /\.scss$/,
        exclude: [/node_modules/, path.resolve(__dirname, "js")],
        use: extractCSS.extract({
          fallback: "style-loader",
          use: [
            {
              loader: "css-loader",
              options: {
                sourceMap: true,
                importLoaders: 1
              }
            },
            {
              loader: "postcss-loader",
              options: {
                sourceMap: true
              }
            },
            {
              loader: "sass-loader",
              options: {
                sourceMap: true,
                includePaths: [path.join(__dirname, "/css")]
              }
            }
          ]
        })
      },
      {
        test: /\.scss$/,
        include: path.resolve(__dirname, "js"),
        use: extractCSS.extract({
          fallback: "style-loader",
          use: [
            {
              loader: "css-loader",
              options: {
                sourceMap: true,
                modules: true,
                camelCase: true,
                importLoaders: 1
              }
            },
            {
              loader: "postcss-loader",
              options: {
                sourceMap: true
              }
            },
            {
              loader: "sass-loader",
              options: {
                sourceMap: true,
                includePaths: [path.join(__dirname, "/css")]
              }
            }
          ]
        })
      }
    ]
  },

  plugins: [
    new webpack.optimize.CommonsChunkPlugin({
      name: "vendor",
      chunks: ["app"],
      minChunks: ({ resource }) => /node_modules/.test(resource)
    }),
    new CopyWebpackPlugin([
      {
        from: { glob: "**/*", dot: false },
        context: path.resolve(__dirname, "static")
      }
    ]),
    extractCSS
  ]
};

let config;

switch (process.env.npm_lifecycle_event) {
  case "deploy":
    config = merge(common, {
      devtool: "nosources-source-map",
      plugins: [new webpack.optimize.ModuleConcatenationPlugin()]
    });
    break;
  default:
    config = merge(common, {
      module: {
        rules: [
          {
            test: /\.js$/,
            enforce: "pre",
            use: [
              {
                loader: "eslint-loader"
              }
            ]
          }
        ]
      },
      devtool: "cheap-eval-source-map"
    });
}

module.exports = config;
