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
        public AppDb Db { get; set; }
        public PlayersController(AppDb db)
        {
            Db = db;
        }

        // GET api/players/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetPlayerInfo(int id)
        {
            await Db.Connection.OpenAsync();
            var query = new PlayerQuery(Db);
            var result = await query.GetPlayerInfo(id);
            if (result is null)
                return new NotFoundResult();
            return new OkObjectResult(result);
        }

        // PATCH api/players/5
        [HttpPatch("{id}")]
        public async Task<IActionResult> UpdateName(int id, [FromBody]Player body)
        {
            await Db.Connection.OpenAsync();
            var query = new PlayerQuery(Db);
            await query.UpdateName(id, body.Name);
            return new OkObjectResult(body);
        }
    }
}
