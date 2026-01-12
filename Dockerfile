# Use the official Bun image
# See https://hub.docker.com/r/oven/bun/tags for specific versions
FROM oven/bun:1

# Set working directory inside the container
WORKDIR /app

# Copy package definition files first to leverage Docker cache
COPY package.json bun.lock ./

# Install dependencies
# We install all dependencies (including dev) to ensure no missing peer dependencies or build tools
RUN bun install --frozen-lockfile

# Copy the rest of the application source code
COPY . .

# Check if the code runs (optional, but good practice for a build)
# RUN bun test

# Set the default command to run the bot
# Users should override the command or pass arguments to run specific strategies
# e.g., docker run -e ... my-image --strategy trend --silent
ENTRYPOINT ["bun", "run", "index.ts"]
