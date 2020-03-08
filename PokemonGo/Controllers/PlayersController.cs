using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PokemonGo.Models;

namespace PokemonGo
{
    [Route("api/players")]
    [ApiController]
    public class PlayersController : ControllerBase
    {
        private AppDb Db { get; }
        public PlayersController(AppDb db)
        {
            Db = db;
        }

        // GET api/blog/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetOne(int id)
        {
            await Db.Connection.OpenAsync();
            var query = new PlayerQuery(Db);
            var result = await query.FindOneAsync(id);
            if (result is null)
                return new NotFoundResult();
            return new OkObjectResult(result);
        }
    }
}
