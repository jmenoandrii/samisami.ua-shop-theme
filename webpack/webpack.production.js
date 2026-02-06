const { EsbuildPlugin } = require('esbuild-loader');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
const { cleanDistFolders } = require('./webpack.parts');
const { merge } = require('webpack-merge');

exports.productionConfig = () => (
  merge(
    {
      devtool: 'hidden-source-map',
      optimization: {
        minimize: true,
        minimizer: [
          new EsbuildPlugin({
            target: 'es2015',
            minify: true
          }),
          new CssMinimizerPlugin()
        ],
      },
    },
    cleanDistFolders()
  )
);
